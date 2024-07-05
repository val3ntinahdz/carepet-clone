class NutritionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index mark_meal_as_completed] ## to be removed
  before_action :select_pet, only: %i[index create_prompt save_nutrition mark_meal_as_completed]

  def index
    @nutrition_data = Nutrition.where(pet: @pet).order(id: :asc)
    return unless Nutrition.where(date: Date.today, pet: @pet).empty?

    prompt = create_prompt
    response = generate_nutrition(prompt)
    nutrition_data = parse_nutrition_data(response)
    save_nutrition(nutrition_data)
  end

  def create_prompt
    <<~PROMPT
      You are a seasoned veterinary with over 20 years of experience.
      Generate a weekly nutritional plan for with the following characteristics: #{@pet} from #{Date.today}
      Your response must be a json ordered by date. The structure of the json is:
      {
      "date":
        {
        "meal_plan":
          {
            "breakfast": { "food_items": "value", "calories": "value", "notes": "value"},
            "lunch": { "food_items": "value", "calories": "value", "notes": "value"},
            "dinner": { "food_items": "value", "calories": "value", "notes": "value"}
          }
        }
      }
    PROMPT
  end

  def generate_nutrition(prompt)
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: 'gpt-4o',
        response_format: { type: 'json_object' },
        messages: [{ role: 'user', content: prompt }]
      }
    )
    response.dig('choices', 0, 'message', 'content')
  end

  def parse_nutrition_data(response)
    JSON.parse(response)
  end

  def save_nutrition(nutrition_data)
    nutrition_data.each do |date, meal_plan|
      meal_plan.each_value do |meal_data|
        meal_data.each do |meal_type, details|
          nutrition = Nutrition.new
          nutrition.date = date
          nutrition.meal_type = meal_type
          nutrition.food_items = details['food_items']
          nutrition.calories = details['calories']
          nutrition.notes = details['notes']
          nutrition.completed = false
          nutrition.pet = @pet
          nutrition.save
        end
      end
    end
  end

  def mark_meal_as_completed
    nutrition = Nutrition.find(params[:nutrition_id])
    nutrition.completed? ? nutrition.completed = false : nutrition.completed = true
    nutrition.pet = @pet
    nutrition.save!
  end

  private

  def select_pet
    @pet = Pet.find(params[:pet_id])
  end
end

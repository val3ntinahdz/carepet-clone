class NutritionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @nutritions = Nutrition.all
    prompt = create_prompt
    response = generate_nutrition(prompt)
    @nutrition_data = create_nutrition_data(response)
    save_nutrition(@nutrition_data)
  end

  private

  def generate_nutrition(prompt)
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
          model: "gpt-4o",
          response_format: { type: "json_object" },
          messages: [{ role: "user", content: prompt}]
      })
      response.dig("choices", 0, "message", "content")
  end

  def create_prompt
    <<~PROMPT
      You are a seasoned veterinary with over 20 years of experience.
      Generate a daily nutritional plan for a dog where the breakfast, lunch and dinner are included.
      Your response must be a json. The structure of the json is: {"breakfast": { "food_items": "ETC...", "calories": "ETC...", "notes": "ETC.."}, "lunch": { "food_items": "ETC...", "calories": "ETC...", "notes": "ETC.."}, "dinner": { "food_items": "ETC...", "calories": "ETC...", "notes": "ETC.."}}
    PROMPT
  end

  def create_nutrition_data(response)
    JSON.parse(response)
  end

  def save_nutrition(nutrition_data)
    date = Date.today
    nutrition_data.each do |meal_type, details|
      nutrition = Nutrition.new
      nutrition.date = date
      nutrition.meal_type = meal_type
      nutrition.food_items = details["food_items"]
      nutrition.calories = details["calories"]
      nutrition.notes = details["notes"]
      nutrition.completed = false
      nutrition.pet_id = 1 ## This is a placeholder. You should replace this with the actual pet_id
      nutrition.save
    end
  end
end

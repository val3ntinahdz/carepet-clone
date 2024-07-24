class TrainingsController < ApplicationController
  before_action :select_pet, only: %i[index create_prompt save_training mark_training_as_completed]

  def index
    @training_data = Training.where(pet: @pet).order(id: :asc)
    return unless Training.where(date: Date.today, pet: @pet).empty?

    prompt = create_prompt
    response = generate_training(prompt)
    training_data = parse_training_data(response)
    save_training(training_data)
  end

  def create_prompt
    <<~PROMPT
      You are a seasoned pet trainer with over 20 years of experience.
      Generate a weekly training plan for with the following characteristics: #{@pet} from #{Date.today}.
      Consider the #{@pet.vaccines}, #{@pet.diseases}, #{@pet.allergies} of the pet.
      Your response must be a json ordered by date. The structure of the json is:
      {
      "date":
        {
        "training_plan": { "title": "value", "description": "value", "duration": "value", "calories_burned": "value" }
        }
      }
    PROMPT
  end

  def generate_training(prompt)
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

  def parse_training_data(response)
    JSON.parse(response)
  end

  def save_training(training_data)
    training_data.each do |date, training_plan|
      training_plan.each_value do |training_detail|
        training = Training.new
        training.date = date
        training.title = training_detail['title']
        training.description = training_detail['description']
        training.duration = training_detail['duration']
        training.calories_burned = training_detail['calories_burned']
        training.completed = false
        training.pet = @pet
        training.save!
      end
    end
  end

  def mark_training_as_completed
    training = Training.find(params[:training_id])
    training.completed? ? training.completed = false : training.completed = true
    training.pet = @pet
    training.save!
  end

  private

  def select_pet
    @pet = Pet.find(params[:pet_id])
  end
end

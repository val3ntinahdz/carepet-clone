require "open-uri"

class Pet < ApplicationRecord
  belongs_to :user
  has_many :vaccinations
  has_many :vaccines, through: :vaccinations
  has_many :conditions
  has_many :diseases, through: :conditions
  has_many :appointments
  has_many :services, through: :appointments
  has_many :veterinaries, through: :services
  has_many :trainings
  has_many :nutritions
  has_many :allergies
  has_many :allergens, through: :allergies
  has_one_attached :photo
  before_create :set_photo

  private

  def set_photo
    puts
    puts
    puts "USING OPEANAI TO GENERATE A PHOTO FOR PET #{name}"
    puts
    puts
    prompt = <<-PROMPT
    Create a high resolution and high-quality Pixar 3D animated film style image of a #{color} #{breed} in nature.
    Capture the essence of the scene with detailed rendering and lifelike textures.
    The #{breed} should have a realistic build and expressive eyes, with a coat that accurately represents the breed's characteristics.
    With a vibrant and dynamic natural background featuring greenery, trees, and a blue sky.
    PROMPT
    client = OpenAI::Client.new
    response = client.images.generate(parameters: { prompt: prompt })
    url = response["data"][0]["url"]
    file =  URI.open(url)
    photo.attach(io: file, filename: "#{id}_#{name}_pet.jpg", content_type: "image/png")
    return photo
  end
end

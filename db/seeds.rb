require 'open-uri'

# Limpiar las tablas existentes

Appointment.destroy_all
Service.destroy_all
Condition.destroy_all
Disease.destroy_all
Allergy.destroy_all
Allergen.destroy_all
Vaccination.destroy_all
Vaccine.destroy_all
Pet.destroy_all
Veterinary.destroy_all
User.destroy_all

# Crear usuarios
user1 = User.create!(
  first_name: 'Maya',
  last_name: 'García',
  email: 'maya@gmail.com',
  phone_number: '5551234567',
  address: 'Av. Félix Cuevas 337, Tlacoquemecatl del Valle, Benito Juárez, 03200 Ciudad de México, CDMX',
  password: "password"
)
user2 = User.create!(
  first_name: 'Valentina',
  last_name: 'León',
  email: 'valentina@gmail.com',
  phone_number: '5552345678',
  address: 'América 103, Parque San Andrés, Coyoacán, 04040 Ciudad de México, CDMX',
  password: "password"
)
user3 = User.create!(
  first_name: 'Donovan',
  last_name: 'Montiel',
  email: 'donovan@gmail.com',
  phone_number: '5553456789',
  address: 'Berlín 3, Del Carmen, Coyoacán, 04100 Ciudad de México, CDMX',
  password: "password"
)
user4 = User.create!(
  first_name: 'Alan',
  last_name: 'Trovo',
  email: 'alan@gmail.com',
  phone_number: '5554567890',
  address: 'Tenayuca 92, Letran Valle, Benito Juárez, 03650 Ciudad de México, CDMX',
  password: "password"
)
user5 = User.create!(
  first_name: 'Andrés',
  last_name: 'López',
  email: 'andres@gmail.com',
  phone_number: '5555678901',
  address: 'Heroes del 47 92, San Diego Churubusco, Coyoacán, 04120 Ciudad de México, CDMX',
  password: "password"
)

# Creacion de usuarios extras para veterinarios

user6 = User.create!(
  first_name: 'Dana',
  last_name: 'Bocaranda',
  email: 'dana@gmail.com',
  phone_number: '5533906542',
  address: 'Calle Gral. Antonio León 31, San Miguel Chapultepec I Secc, Miguel Hidalgo, 11850 Ciudad de México, CDMX',
  password: 'password'
)

user7 = User.create!(
  first_name: 'Elisa',
  last_name: 'Herrera',
  email: 'elisa@gmail.com',
  phone_number: '5577841201',
  address: 'C. Cádiz Nte. 38, Extremadura Insurgentes, Benito Juárez, 03740 Ciudad de México, CDMX',
  password: "password"
)

user8 = User.create!(
  first_name: 'Luisa',
  last_name: 'Casas',
  email: 'luisa@gmail.com',
  phone_number: '5559874500',
  address: 'C. 12 31, San Pedro de los Pinos, Benito Juárez, 03800 Ciudad de México, CDMX',
  password: "password"
)

user9 = User.create!(
  first_name: 'Roberto',
  last_name: 'Dionisious',
  email: 'roberto@gmail.com',
  phone_number: '5587559832',
  address: 'C. Nueva York 304, Nápoles, Benito Juárez, 03810 Ciudad de México, CDMX',
  password: "password"
)

# Crear veterinarios

vet1 = Veterinary.create!(
  dni: '123456789',
  specialization: 'Cardiology',
  user_id: user4.id
)
vet2 = Veterinary.create!(
  dni: '987654321',
  specialization: 'General',
  user_id: user5.id
)

vet3 = Veterinary.create!(
  dni: '135792468',
  specialization: 'General',
  user_id: user3.id
)

vet4 = Veterinary.create!(
  dni: '98639002',
  specialization: 'General',
  user_id: user6.id
)

vet5 = Veterinary.create!(
  dni: '475920874',
  specialization: 'Surgery',
  user_id: user7.id
)

vet6 = Veterinary.create!(
  dni: '0388492039',
  specialization: 'Dermatology',
  user_id: user8.id
)

vet7 = Veterinary.create!(
  dni: '475920874',
  specialization: 'Surgery',
  user_id: user9.id
)

# Crear mascotas

pets = [
  {
    name: 'Buddy',
    pet_type: 'Dog',
    breed: 'Labrador',
    birthday_date: '2018-03-25',
    gender: 'Male',
    weight: 30,
    height: 60,
    color: 'Black',
    user_id: user1.id
  },
  {
    name: 'Kitty',
    pet_type: 'Cat',
    breed: 'Siamese',
    birthday_date: '2019-05-14',
    gender: 'Female',
    weight: 10,
    height: 25,
    color: 'White',
    user_id: user1.id
  },
  {
    name: 'Max',
    pet_type: 'Dog',
    breed: 'Beagle',
    birthday_date: '2017-07-22',
    gender: 'Male',
    weight: 20,
    height: 40,
    color: 'Brown',
    user_id: user2.id
  }
]

pet_images_urls = [
  "https://res.cloudinary.com/drlgwfwr5/image/upload/v1720304632/development/wk1ikpnsswu2uq1mw5c2.png",
  "https://res.cloudinary.com/drlgwfwr5/image/upload/v1720304632/development/nnlbnoh8suxtcowadzd4.png",
  "https://res.cloudinary.com/drlgwfwr5/image/upload/v1720304632/development/tufpb2nbqsouqn5ds7xq.png",
]

pets.each_with_index do |pet, i|
  Pet.skip_callback(:create, :before, :set_photo)
  new_pet = Pet.new(pet)
  file =  URI.open(pet_images_urls[i])
  new_pet.photo.attach(io: file, filename: "#{pet[:name]}_pet.jpg", content_type: "image/png")
  new_pet.save!
  Pet.set_callback(:create, :before, :set_photo)
end

# Crear vacunas, alérgenos y enfermedades

vaccines = [
  "Rabies",
  "Distemper",
  "Parvovirus",
  "Adenovirus",
  "Leptospirosis",
  "Bordetella",
  "Lyme Disease",
  "Canine Influenza",
  "Corona Virus"
]

allergens = [
  "Pollen",
  "Dust Mites",
  "Fleas",
  "Food Allergies",
  "Mold Spores",
  "Insect Bites",
  "Chemical Irritants",
  "Plant Allergens",
  "Animal Dander"
]

diseases = [
  "Arthritis",
  "Diabetes",
  "Heart Disease",
  "Kidney Disease",
  "Liver Disease",
  "Hypothyroidism",
  "Hyperthyroidism",
  "Cancer",
  "Obesity"
]

vaccines.each { |name| Vaccine.create!(name: name) }
allergens.each { |name| Allergen.create!(name: name) }
diseases.each { |name| Disease.create!(name: name) }

# Descripciones reales para los servicios

service_descriptions = {
  "Surgery" => "Comprehensive surgical care including pre-operative assessments, anesthesia, and post-operative care to ensure the best outcomes for your pet.",
  "Consultation" => "Professional veterinary consultations to address any health concerns, perform physical exams, and provide expert advice on your pet's well-being.",
  "Dentistry" => "Advanced dental care services including cleanings, extractions, and oral health assessments to maintain your pet's dental hygiene.",
  "Vaccination" => "Essential vaccination services to protect your pet from common and potentially life-threatening diseases.",
  "Emergency" => "Immediate and critical care for pets in emergency situations, providing life-saving treatments and interventions.",
  "Wellness" => "Comprehensive wellness exams to monitor your pet's health, prevent diseases, and ensure a long and healthy life.",
  "Nutrition" => "Personalized nutrition plans and dietary consultations to meet the specific needs of your pet.",
  "Behavioral" => "Behavioral consultations and training to address any behavioral issues and improve your pet's quality of life.",
  "Dermatology" => "Specialized dermatology services to diagnose and treat skin conditions, allergies, and other dermatological issues."
}

# Crear un servicio para cada veterinario

veterinaries = Veterinary.all

veterinaries.each do |veterinary|
  2.times do
  value = service_descriptions.keys.sample
  Service.create!(
    name: value,
    category: value,
    description: service_descriptions[value],
    fee: rand(50.0..300.0).round(2),
    veterinary: veterinary
  )
  end
end

# Crear citas con datos reales para cada servicio

appointment_data = [
  { datetime: "2024-07-27 10:00:00", reason: "Routine Checkup", status: "Scheduled" },
  { datetime: "2024-07-28 11:00:00", reason: "Vaccination", status: "Completed" },
  { datetime: "2024-07-29 12:00:00", reason: "Dental Cleaning", status: "Scheduled" },
]

Pet.all.each do |pet|
  puts "Processing Pet: #{pet.id} - #{pet.name}"

  service = Service.all.sample
  if service.nil?
    puts "No services found!"
    next
  end

  puts "Selected Service: #{service.id} - #{service.name}"

  appointment_data.each do |data|
    puts "Creating appointment for Pet #{pet.id} with Service #{service.id} at #{data[:datetime]}"
    begin
      Appointment.create!(
        datetime: data[:datetime],
        reason: data[:reason],
        status: data[:status],
        pet_id: pet.id,
        service_id: service.id,
        fee: service.fee
      )
      puts "Appointment created successfully"
    rescue => e
      puts "Failed to create appointment: #{e.message}"
    end
  end
end


pet1 = Pet.first
Vaccination.create!(pet_id: pet1.id, date: Date.today, comments: 'comentario', vaccine_id: Vaccine.first.id)
Allergy.create!(detected_on: '2021/02/04', severity: 'leve', reactions: 'ojos rojos', comments: 'comentario', pet_id: pet1.id, allergen_id: Allergen.first.id)
Condition.create!(diagnosis_date: '2020/09/13', recovery_date: '2020/12/04', comments: 'Control his weigth, follow a trainning and nutritional plan', pet_id: pet1.id, disease_id: Disease.first.id)

pet2 = Pet.second
Vaccination.create!(pet_id: pet2.id, date: Date.today, comments: 'comentario', vaccine_id: Vaccine.second.id)
Allergy.create!(detected_on: '2023/07/24', severity: 'fuerte', reactions: 'ronchas en la piel', comments: 'comentario', pet_id: pet2.id, allergen_id: Allergen.second.id)
Condition.create!(diagnosis_date: '2023/01/22', recovery_date: Date.today, comments: 'Walk your dog for 10 minutes everyday', pet_id: pet2.id, disease_id: Disease.second.id)

pet3 = Pet.last
Vaccination.create!(pet_id: pet3.id, date: '2024/03/15', comments: 'comentario', vaccine_id: Vaccine.last.id)
Allergy.create!(detected_on: '2022/05/21', severity: 'media', reactions: 'estornudos', comments: 'comentario', pet_id: pet3.id, allergen_id: Allergen.last.id)
Condition.create!(diagnosis_date: '2023/10/09', recovery_date: Date.today, comments: 'Extrict diet and trainning plan', pet_id: pet3.id, disease_id: Disease.last.id)


puts "Seed data generated successfully!"

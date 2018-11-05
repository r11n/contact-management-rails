# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating a seed domain to allow user creation
domain = AllowedDomain.find_by(domain: "inmar.com")
domain = AllowedDomain.create(domain: "inmar.com") if domain.nil?

# seed admin
user = User.find_by(email: "support@inmar.com")
user = User.create(email: "support@inmar.com", password: "9n13a18", password_confirmation: "9n13a18", name: "Admin", personal_identity_number: "no number for support") if !user.present?

# seed role
role = Role.find_by(name: "admin")
role = Role.create(name: "admin") if !role.present?

user_role = UserRole.find_by(user_id: user.id, role_id: role.id)
user_role = UserRole.create(user_id: user.id, role_id: role.id) if !user_role.present?
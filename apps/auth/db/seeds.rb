if Rails.env.development?
  [
    ['admin1@example.com', "admin", "Mayra", "Rowe"],
    ['dev1@example.com', "developer", "Elisha", "Corwin"],
    ['dev2@example.com', "developer", "Edythe", "Lemke"],
    ['dev3@example.com', "developer", "Tomas", "Grady"],
    ['manager1@example.com', "manager", "Keven", "Huel"],
    ['accountant1@example.com', "accountant", "Rusty", "Hodkiewicz"]
  ].each do |email, role, first_name, last_name|
    pass = 'password'

    Employees::Create.new.call(
      email:,
      password: pass,
      password_confirmation: pass,
      role:,
      first_name:,
      last_name:
    )
  end
end

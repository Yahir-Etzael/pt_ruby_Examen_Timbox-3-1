demo = User.find_or_initialize_by(email: "demo@example.com")
demo.update!(
  name: "Usuario Demo",
  rfc: "XAXX010101000",
  password: "Password123",
  password_confirmation: "Password123",
  admin: true
)

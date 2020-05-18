class CreateUserService
  attr_reader :params

  def initialize(params)
    default_params = {
      email: nil,
      phone: nil,
      first_name: nil,
      last_name: nil
    }
    @params = default_params.merge(params.slice(*default_params.keys))
  end

  def perform
    User.create(params)
  end
end

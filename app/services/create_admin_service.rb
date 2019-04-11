class CreateAdminService
  # this is not what services are for, but good try
  def call
    User.find_or_create_by!(email: ENV['USER_MAIL']) do |user|
      user.password = ENV['USER_PSWD']
      user.password_confirmation = ENV['USER_PSWD']
      user.username = ENV['USERNAME']
      user.admin!
    end
  end
end

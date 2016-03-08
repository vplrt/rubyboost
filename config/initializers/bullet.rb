if Rails.env.development?
  Rails.application.config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
  end
end

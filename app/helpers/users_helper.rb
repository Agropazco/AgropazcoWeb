module UsersHelper

  # Returns the Gravatar for the given user
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def role_name(role)
    { vendor: :Vendedor, buyer: :Comprador, admin: :Administrador }[role.to_sym]
  end
end


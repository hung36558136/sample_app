module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Deathly_Hallows_Sign.svg/150px-Deathly_Hallows_Sign.svg.png"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end

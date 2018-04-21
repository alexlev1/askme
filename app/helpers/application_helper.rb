module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar-template.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def question_decline(number, vopros, voprosa, voprosov)
    remain = number % 10
    big_remain = number % 100

    return voprosov if big_remain.between?(11, 14)

    case remain
    when 1
      return vopros
    when 2..4
      return voprosa
    when 0
      return voprosov
    else
      return voprosov
    end
  end
end

module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar-template.jpg'
    end
  end

  def question_decline(number)
    remain = number % 10
    big_remain = number % 100

    return "Всего: #{number} вопросов" if big_remain.between?(11, 14)

    case remain
    when 1
      return "Всего: #{number} вопрос"
    when 2..4
      return "Всего: #{number} вопроса"
    when 0
      return "К пользователю нет вопросов..."
    else
      return "Всего: #{number} вопросов"
    end
  end
end

class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Alex',
        username: 'lev',
        avatar_url: 'http://cv.alevashov.ru/images/avatar.png',
      ),
      User.new(
        id: 2,
        name: 'George',
        username: 'goga'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Alex',
      username: 'lev',
      avatar_url: 'http://cv.alevashov.ru/images/avatar.png',
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('13.04.2018')),
      Question.new(text: 'На работу пойдём?', created_at: Date.parse('15.04.2018'))
    ]

    @new_question = Question.new
  end
end

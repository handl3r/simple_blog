# Something can be confuse: https://domain.com/users/1/following should be a set
# of users these are following user with id = 1
# and https://domain.com/users/1/followers should be a set of users that being
# followed by user with id = 1

Rails.application.routes.draw do
  resources :admins

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments, only: %i[create edit destroy]
  end

  resources :follows, only: %i[create destroy]
end

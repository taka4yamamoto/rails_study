Rails.application.routes.draw do
  get 'static_pages/hoge'

  get 'static_pages/help'

  root 'application#hello'
end

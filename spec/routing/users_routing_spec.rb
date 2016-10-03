require 'rails_helper'

RSpec.describe UsersController do
  it { expect(get('/register')).to route_to(controller: 'users', action: 'new') }
  it { expect(get(new_user_path)).to route_to(controller: 'users', action: 'new') }

  it { expect(post('/users/create')).to route_to(controller: 'users', action: 'create') }
  it { expect(post(create_user_path)).to route_to(controller: 'users', action: 'create') }
end

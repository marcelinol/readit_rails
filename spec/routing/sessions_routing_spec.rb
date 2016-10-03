require 'rails_helper'

RSpec.describe SessionsController do
  it { expect(get('/login')).to route_to(controller: 'sessions', action: 'new') }
  it { expect(get(new_session_path)).to route_to(controller: 'sessions', action: 'new') }

  it { expect(post('/login')).to route_to(controller: 'sessions', action: 'create') }
  it { expect(post(create_session_path)).to route_to(controller: 'sessions', action: 'create') }

  it { expect(delete('/logout')).to route_to(controller: 'sessions', action: 'destroy') }
  it { expect(delete(destroy_session_path)).to route_to(controller: 'sessions', action: 'destroy') }
end

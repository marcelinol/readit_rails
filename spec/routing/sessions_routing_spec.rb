require 'rails_helper'

RSpec.describe SessionsController do
  it { expect(get('/login')).to route_to(controller: 'sessions', action: 'new') }
  it { expect(get(log_in_path)).to route_to(controller: 'sessions', action: 'new') }

  it { expect(post('/login')).to route_to(controller: 'sessions', action: 'create') }
  it { expect(post(sign_up_path)).to route_to(controller: 'sessions', action: 'create') }

  it { expect(delete('/logout')).to route_to(controller: 'sessions', action: 'destroy') }
  it { expect(delete(log_out_path)).to route_to(controller: 'sessions', action: 'destroy') }
end

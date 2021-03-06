require 'rails_helper'

RSpec.describe AffiliatesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/affiliates').to route_to('affiliates#index')
    end

    it 'routes to #new' do
      expect(get: '/affiliates/new').to route_to('affiliates#new')
    end

    it 'routes to #show' do
      expect(get: '/affiliates/1').to route_to('affiliates#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/affiliates/1/edit').to route_to('affiliates#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/affiliates').to route_to('affiliates#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/affiliates/1').to route_to('affiliates#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/affiliates/1').to route_to('affiliates#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/affiliates/1').to route_to('affiliates#destroy', id: '1')
    end
  end
end

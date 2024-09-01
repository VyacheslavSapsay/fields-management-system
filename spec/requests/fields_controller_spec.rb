# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FieldsController' do
  describe 'GET #index' do
    before { create_list(:field, 15) }

    it 'returns http success' do
      get fields_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    let(:field) { create(:field) }

    it 'returns http success' do
      get edit_field_path(field)
      expect(response).to have_http_status(:success)
    end
  end
end

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

  describe 'PATCH #update' do
    let(:field) { create(:field) }
    let(:shape_to_update) { build(:field).shape.to_json }

    let(:valid_params) do
      {
        field: {
          name: "some name",
          shape: shape_to_update
        }
      }
    end

    it 'updates successfully and redirects' do
      patch field_path(field), params: valid_params
      expect(response).to have_http_status(302)
    end

    it 'updates return unprocessable_entity' do
      patch field_path(field), params: { field: { shape: nil, name: nil }}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST #create' do
    let(:shape_to_create) { build(:field).shape.to_json }

    let(:valid_params) do
      {
        field: {
          name: "some name",
          shape: shape_to_create
        }
      }
    end

    it 'creates successfully and redirects' do
      post fields_path, params: valid_params
      expect(response).to have_http_status(302)
    end

    it 'returns unprocessable_entity' do
      post fields_path, params: { field: { shape: nil, name: nil }}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

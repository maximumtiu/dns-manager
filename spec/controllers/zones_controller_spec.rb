require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe ZonesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Zone. As you add validations to Zone, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { zone: 'example.com' }
  }

  let(:invalid_attributes) {
    { zone: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ZonesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:ns1_success) do
    Typhoeus::Response.new(
      code: 200,
      return_code: :ok,
      body: { dns_servers: ["dns1.p04.nsone.net", "dns2.p04.nsone.net", "dns3.p04.nsone.net", "dns4.p04.nsone.net"] }.to_json
    )
  end

  let(:ns1_failure) do
    Typhoeus::Response.new(
      code: 500,
      return_code: :ok,
      body: { message: 'Something went wrong' }.to_json
    )
  end


  describe "GET #index" do
    it "returns a success response" do
      Zone.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      zone = Zone.create! valid_attributes
      get :show, params: {id: zone.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      zone = Zone.create! valid_attributes
      get :edit, params: {id: zone.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context 'when the NS1 request is successful' do
      before do
        allow(Ns1::Zone).to receive(:create)
          .and_return(ns1_success)
      end

      context "with valid params" do
        it "creates a new Zone" do
          expect {
            post :create, params: {zone: valid_attributes}, session: valid_session
          }.to change(Zone, :count).by(1)
        end

        it "redirects to the created zone" do
          post :create, params: {zone: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Zone.last)
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          post :create, params: {zone: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    context 'when NS1 returns an error' do
      before do
        allow(Ns1::Zone).to receive(:create)
          .and_return(ns1_failure)
      end

      it 'redirects to the form' do
        post :create, params: {zone: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(new_zone_path)
      end

      it 'displays an error message to the user' do
        post :create, params: {zone: invalid_attributes}, session: valid_session
        expect(flash[:notice]).to match(/try again/)
      end
    end
  end

  describe "PUT #update" do
    context 'when the NS1 request is successful' do
      before do
        allow(Ns1::Zone).to receive(:update)
          .and_return(ns1_success)
      end

      context "with valid params" do
        let(:new_attributes) {
          { zone: 'example.org' }
        }

        it "updates the requested zone" do
          zone = Zone.create! valid_attributes
          put :update, params: {id: zone.to_param, zone: new_attributes}, session: valid_session
          zone.reload
          expect(zone.zone).to eq 'example.org'
        end

        it "redirects to the zone" do
          zone = Zone.create! valid_attributes
          put :update, params: {id: zone.to_param, zone: valid_attributes}, session: valid_session
          expect(response).to redirect_to(zone)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          zone = Zone.create! valid_attributes
          put :update, params: {id: zone.to_param, zone: invalid_attributes}, session: valid_session
          expect(response).to be_successful
        end
      end
    end

    context 'when NS1 returns an error' do
      let(:zone) { Zone.create! valid_attributes }
      before do
        allow(Ns1::Zone).to receive(:update)
          .and_return(ns1_failure)
      end

      it 'redirects to the form' do
        put :update, params: {id: zone.to_param, zone: invalid_attributes}, session: valid_session
        expect(response).to redirect_to(new_zone_path)
      end

      it 'displays an error message to the user' do
        put :update, params: {id: zone.to_param, zone: invalid_attributes}, session: valid_session
        expect(flash[:notice]).to match(/try again/)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:zone) { Zone.create! valid_attributes }
    let(:ns1_success) do
      Typhoeus::Response.new(
        code: 200,
        return_code: :ok,
        body: {}.to_json
      )
    end

    let(:ns1_failure) do
      Typhoeus::Response.new(
        code: 404,
        return_code: :ok,
        body: { message: 'zone not found' }.to_json
      )
    end

    context 'when the NS1 request is successful' do
      before do
        allow(Ns1::Zone).to receive(:destroy)
          .and_return(ns1_success)
      end

      it "destroys the requested zone" do
        expect {
          delete :destroy, params: {id: zone.to_param}, session: valid_session
        }.to change(Zone, :count).by(-1)
      end

      it "redirects to the zones list" do
        delete :destroy, params: {id: zone.to_param}, session: valid_session
        expect(response).to redirect_to(zones_url)
      end
    end

    context 'when NS1 returns an error' do
      before do
        allow(Ns1::Zone).to receive(:destroy)
          .and_return(ns1_failure)
      end

      let(:back) { zones_url + "/#{zone.id}" }
      before { request.env['HTTP_REFERER'] = back }

      it 'redirects back' do
        delete :destroy, params: { id: zone.to_param }, session: valid_session
        expect(response).to redirect_to(back)
      end

      it 'displays an error message to the user' do
        delete :destroy, params: { id: zone.to_param }, session: valid_session
        expect(flash[:notice]).to match(/try again/)
      end

      context 'when redirecting back is not an option' do
        before { request.env['HTTP_REFERER'] = nil }

        it 'redirects to /zones' do
          delete :destroy, params: { id: zone.to_param }, session: valid_session
          expect(response).to redirect_to(zones_url)
        end
      end
    end
  end

end

require 'spec_helper'

describe PeopleController do
 
  let!(:user) { User.create!(email: 'test1021@email.com', 
                            password: 'password123', 
                            highrise_url: 'https//test.highrisehq.com',
                            highrise_token: '111') }
  
  let!(:attributes) { { "name" => "TestName", "user_id" => user.id } }
  let!(:person) { Person.create!({ "name" => "TestName", "user_id" => user.id }) }

  describe "GET index" do
    it "assigns all people as @people" do
      sign_in user
      get :index, {}
      expect(assigns(:people)).to(eq([person]))
    end
  end

  describe "GET show" do
    it "assigns the requested person as @person" do
      sign_in user
      get :show, {:id => person.to_param}
      expect(assigns(:person)).to(eq(person))
    end
  end

  describe "GET new" do
    it "assigns a new person as @person" do
      sign_in user
      get :new, {}
      expect(assigns(:person)).to(be_a_new(Person))
    end
  end

  describe "GET edit" do
    it "assigns the requested person as @person" do
      sign_in user
      get :edit, {:id => person.to_param}
      expect(assigns(:person)).to(eq(person))
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Person" do
        sign_in user
        expect { 
          post :create, { :person => attributes }
        }.to change(Person, :count).by(1)
      end

      it "assigns a newly created person as @person" do
        sign_in user
        post :create, { :person => attributes }
        expect(assigns(:person)).to(be_a(Person))
        expect(assigns(:person)).to(be_persisted)
      end

      it "redirects to the created person" do
        sign_in user
        post :create, {:person => attributes}
        expect(response).to(redirect_to(Person.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved person as @person" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to(receive(:save).and_return(false))
        post :create, {:person => { "name" => "invalid value" }}
        expect(assigns(:person)).to(be_a_new(Person))
      end

      it "re-renders the 'new' template" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to(receive(:save).and_return(false))
        post :create, {:person => { "name" => "invalid value" }}
        expect(response).to(render_template("new"))
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested person" do
        sign_in user
        allow_any_instance_of(Person).to receive(:update_attributes).with({ "name" => "TestName" })
        put :update, {:id => person.to_param, :person => { "name" => "TestName" }}
      end

      it "assigns the requested person as @person" do
        sign_in user
        put :update, {:id => person.to_param, :person => attributes}
        expect(assigns(:person)).to(eq(person))
      end

      it "redirects to the person" do
        sign_in user
        put :update, {:id => person.to_param, :person => attributes}
        response.should redirect_to(person)
      end
    end

    describe "with invalid params" do
      it "assigns the person as @person" do
        sign_in user
        allow_any_instance_of(Person).to receive(:save).and_return(false)
        put :update, {:id => person.to_param, :person => { "name" => "invalid value" }}
        expect(assigns(:person)).to(eq(person))
      end

      it "re-renders the 'edit' template" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to receive(:save).and_return(false)
        put :update, {:id => person.to_param, :person => { "name" => "invalid value" }}
        response.should render_template("edit")
      end
      
      it "re-renders the 'edit' template when invalid e-mail" do
        sign_in user
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Person).to receive(:save).and_return(false)
        put :update, {:id => person.to_param, :person => { "name" => "invalid value", "e-mail" => "invalid e-mail" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested person" do
      sign_in user
      expect {
        delete :destroy, {:id => person.to_param}
      }.to change(Person, :count).by(-1)
    end

    it "redirects to the people list" do
      sign_in user
      delete :destroy, {:id => person.to_param}
      expect(response).to(redirect_to(people_url))
    end
  end
  
  describe "GET save to highrise" do
    it "saves person to highrise" do
      #Sidekiq::Worker.clear_all
      #sign_in user
      #get :save_to_highrise, {:id => person.to_param}
    end
  end
  
end
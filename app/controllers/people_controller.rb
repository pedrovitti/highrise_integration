class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :delete_from_highrise, :save_to_highrise]

  # GET /people
  # GET /people.json
  def index
    @people = current_user.people
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.user = current_user

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
  
  def save_to_highrise
     @person.highrise_id = @person.save_to_highrise
     @person.save
     redirect_to '/', notice: "Person was saved to Highrise with id:#{@person.highrise_id}."
  end

  def delete_from_highrise
     @person.delete_from_highrise
     @person.highrise_id=nil
     @person.save
     redirect_to '/', notice: 'Person was successfully deleted from Highrise'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      if params[:id]!=nil
        @person = Person.find(params[:id])
      else
        @person = Person.find(params[:person_id])
      end 
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :last_name, :email, :company, :job_title, :phone, :website, :highrise_id)
    end
end

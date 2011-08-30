class PersonaTiposController < ApplicationController
  before_filer :authenticate

  def index
    @persona_tipos = PersonaTipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @persona_tipos }
    end
  end


    def show
    @persona_tipo = PersonaTipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @persona_tipo }
    end
  end

  # GET /talleres/new
  # GET /talleres/new.json
  def new
    @persona_tipo = PersonaTipo.new
    if current_user.is_admin?
      @congresos = Congreso.all(:order => "nombre")
    else
      @congresos = current_user.congresos(:order => "nombre")
    end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @persona_tipo }
    end
  end

  # GET /talleres/1/edit
  def edit
    @persona_tipo = PersonaTipo.find(params[:id])
    if current_user.is_admin?
      @congresos = Congreso.all(:order => "nombre")
    else
      @congresos = current_user.congresos(:order => "nombre")
    end
  end

  # POST /talleres
  # POST /talleres.json
  def create
    @persona_tipo = PersonaTipo.new(params[:persona_tipo])

    respond_to do |format|
      if @persona_tipo.save
        format.html { redirect_to @persona_tipo, notice: 'Tipo de Participante registrado correctamente.' }
        format.json { render json: @congreso, status: :created, location: @persona_tipo }
      else
        if current_user.is_admin?
          @congresos = Congreso.all(:order => "nombre")
      else
          @congresos = current_user.congresos(:order => "nombre")
      end
        format.html { render action: "new" }
        format.json { render json: @persona_tipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talleres/1
  # PUT /talleres/1.json
  def update
    @persona_tipo = PersonaTipo.find(params[:id])

    respond_to do |format|
      if @persona_tipo.update_attributes(params[:persona_tipo])
        format.html { redirect_to @persona_tipo, notice: 'Tipo de participante actualizado correctamente.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @persona_tipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talleres/1
  # DELETE /talleres/1.json
  def destroy
    @persona_tipo = PersonaTipo.find(params[:id])
    @persona_tipo.destroy

    respond_to do |format|
        format.html { redirect_to persona_tipos_url }
        format.json { head :ok }
    end
  end
end

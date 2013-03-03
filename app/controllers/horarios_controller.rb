class HorariosController < ApplicationController
  # GET /horarios
  # GET /horarios.json
  def index
    @horarios = Horario.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @horarios }
    end
  end

  # GET /horarios/1
  # GET /horarios/1.json
  def show
    @horario = Horario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @horario }
    end
  end

  # GET /horarios/new
  # GET /horarios/new.json
  def new
    @horario = Horario.new
    if current_user.is_admin?
      @congresos = Congreso.all(:order => "nombre")
    else
      @congresos = current_user.congresos(:order => "nombre")
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @horario }
    end
  end

  # GET /horarios/1/edit
  def edit
    @horario = Horario.find(params[:id])
  end

  # POST /horarios
  # POST /horarios.json
  def create
    @horario = Horario.new(params[:horario])

    respond_to do |format|
      if @horario.save
        format.html { redirect_to @horario, notice: 'Horario was successfully created.' }
        format.json { render json: @horario, status: :created, location: @horario }
      else
        format.html { render action: "new" }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /horarios/1
  # PUT /horarios/1.json
  def update
    @horario = Horario.find(params[:id])

    respond_to do |format|
      if @horario.update_attributes(params[:horario])
        format.html { redirect_to @horario, notice: 'Horario was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @horario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horarios/1
  # DELETE /horarios/1.json
  def destroy
    @horario = Horario.find(params[:id])
    @horario.destroy

    respond_to do |format|
      format.html { redirect_to horarios_url }
      format.json { head :ok }
    end
  end
end

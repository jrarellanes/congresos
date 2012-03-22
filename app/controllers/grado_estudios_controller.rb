class GradoEstudiosController < ApplicationController
  # GET /grado_estudios
  # GET /grado_estudios.json
  def index
    @grado_estudios = GradoEstudio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grado_estudios }
    end
  end

  # GET /grado_estudios/1
  # GET /grado_estudios/1.json
  def show
    @grado_estudio = GradoEstudio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grado_estudio }
    end
  end

  # GET /grado_estudios/new
  # GET /grado_estudios/new.json
  def new
    @grado_estudio = GradoEstudio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grado_estudio }
    end
  end

  # GET /grado_estudios/1/edit
  def edit
    @grado_estudio = GradoEstudio.find(params[:id])
  end

  # POST /grado_estudios
  # POST /grado_estudios.json
  def create
    @grado_estudio = GradoEstudio.new(params[:grado_estudio])

    respond_to do |format|
      if @grado_estudio.save
        format.html { redirect_to @grado_estudio, notice: 'Grado estudio was successfully created.' }
        format.json { render json: @grado_estudio, status: :created, location: @grado_estudio }
      else
        format.html { render action: "new" }
        format.json { render json: @grado_estudio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grado_estudios/1
  # PUT /grado_estudios/1.json
  def update
    @grado_estudio = GradoEstudio.find(params[:id])

    respond_to do |format|
      if @grado_estudio.update_attributes(params[:grado_estudio])
        format.html { redirect_to @grado_estudio, notice: 'Grado estudio was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grado_estudio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grado_estudios/1
  # DELETE /grado_estudios/1.json
  def destroy
    @grado_estudio = GradoEstudio.find(params[:id])
    @grado_estudio.destroy

    respond_to do |format|
      format.html { redirect_to grado_estudios_url }
      format.json { head :ok }
    end
  end
end

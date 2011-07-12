class CongresosController < ApplicationController
  # GET /congresos
  # GET /congresos.json
  def index
    @congresos = Congreso.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @congresos }
    end
  end

  # GET /congresos/1
  # GET /congresos/1.json
  def show
    @congreso = Congreso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @congreso }
    end
  end

  # GET /congresos/new
  # GET /congresos/new.json
  def new
    @congreso = Congreso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @congreso }
    end
  end

  # GET /congresos/1/edit
  def edit
    @congreso = Congreso.find(params[:id])
  end

  # POST /congresos
  # POST /congresos.json
  def create
    @congreso = Congreso.new(params[:congreso])

    respond_to do |format|
      if @congreso.save
        format.html { redirect_to @congreso, notice: 'Congreso registrado correctamente.' }
        format.json { render json: @congreso, status: :created, location: @congreso }
      else
        format.html { render action: "new" }
        format.json { render json: @congreso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /congresos/1
  # PUT /congresos/1.json
  def update
    @congreso = Congreso.find(params[:id])

    respond_to do |format|
      if @congreso.update_attributes(params[:congreso])
        format.html { redirect_to @congreso, notice: 'Congreso actualizado correctamente.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @congreso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /congresos/1
  # DELETE /congresos/1.json
  def destroy
    @congreso = Congreso.find(params[:id])
    @congreso.destroy

    respond_to do |format|
      format.html { redirect_to congresos_url }
      format.json { head :ok }
    end
  end
end

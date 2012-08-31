class TalleresController < ApplicationController
  before_filter :authenticate
  # GET /talleres
  # GET /talleres.json
  def index
    @talleres = Taller.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talleres }
    end
  end

  # GET /talleres/1
  # GET /talleres/1.json
  def show
    @taller = Taller.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @taller }
    end
  end

  # GET /talleres/new
  # GET /talleres/new.json
  def new
    @taller = Taller.new
    if current_user.is_admin?
      @congresos = Congreso.all(:order => "nombre")
    else
      @congresos = current_user.congresos(:order => "nombre")
    end
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @taller }
    end
  end

  # GET /talleres/1/edit
  def edit
    @taller = Taller.find(params[:id])
    if current_user.is_admin?
      @congresos = Congreso.all(:order => "nombre")
    else
      @congresos = current_user.congresos(:order => "nombre")
    end
  end

  # POST /talleres
  # POST /talleres.json
  def create
    @taller = Taller.new(params[:taller])
    @taller.hora = "#{params[:date][:hour]}:#{params[:date][:minute]}"

    respond_to do |format|
      if @taller.save
        format.html { redirect_to @taller, notice: 'Taller registrado correctamente.' }
        format.json { render json: @congreso, status: :created, location: @taller }
      else
        if current_user.is_admin?
          @congresos = Congreso.all(:order => "nombre")
      else
          @congresos = current_user.congresos(:order => "nombre")
      end
        format.html { render action: "new" }
        format.json { render json: @taller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talleres/1
  # PUT /talleres/1.json
  def update
    @taller = Taller.find(params[:id])

    respond_to do |format|
      if @taller.update_attributes(params[:taller])
        format.html { redirect_to @taller, notice: 'Taller actualizado correctamente.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @taller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talleres/1
  # DELETE /talleres/1.json
  def destroy
    @taller = Taller.find(params[:id])
    if taller_propio?(@taller) or current_user.is_admin?
      @taller.destroy
      respond_to do |format|
          format.html { redirect_to talleres_url }
          format.json { head :ok }
    end
    else
      flash[:notice] = "Solo puedes eliminar tus propios talleres"
      redirect_to talleres_url
    end

    
  end
end

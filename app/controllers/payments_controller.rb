class PaymentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_user, only: [:new, :create, :edit, :update]
    before_action :check_existing_payment, only: [:new, :create]
    before_action :check_payment_id, only: [:edit, :update]
    
    def index
        @user = current_user
        @payment = Payment.new
        render :new
        #temporary workaround to keep users on the new form in case they reload the page
    end

    def show
        @user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
        render :edit
        #temporary workaround to keep users on the edit form in case they reload the page
    end

    def new
        @user = current_user
        @payment = Payment.new
    end

    def create
        @user = current_user
        @payment = Payment.new(payment_params)
        @payment.user = @user
        if @payment.save
            flash.notice = "Payment information saved"
            redirect_to profile_home_index_path
        else
            render(action: :new)
        end
    end

    def edit
        @user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
    end

    def update
        @user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
        if @payment.update(payment_params) && @payment.valid?
            flash.notice = "Payment information updated"
            redirect_to profile_home_index_path
        else  
            render :edit
        end
    end

    def check_user
        if current_user.id != params[:user_id].to_i
            flash.alert = "Unable to access requested resource. Check for proper URL."
            redirect_to profile_home_index_path
        end
    end
    

    def check_payment_id
        @user = current_user
        if @user.payment.id != params[:id].to_i
            flash.alert = "Unable to access requested resource. Check for proper URL."
            redirect_to profile_home_index_path
        end
    end

        

    def check_existing_payment
        @user = current_user
        @payment = Payment.find_by(user_id: @user)
        if @payment.present?
            redirect_to edit_user_payment_path(user_id: @user, id: @payment) and return true
        end
    end

    private
    
    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_number, :cvv, :exp_month, :exp_year)
    end

end

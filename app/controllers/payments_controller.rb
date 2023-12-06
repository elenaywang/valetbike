class PaymentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_user, only: [:new, :show, :edit]
    before_action :check_payment, only: [:show, :edit]
    #validators for form input here

    # def index
    #     @payment = Payment.order(:first_name)
    # end

    def show
        #@user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
    end

    def new
        if current_user.payment_id.blank?
            @user = current_user
            @payment = Payment.new
        else
            redirect_to edit_user_payment_path(id: current_user.payment_id)
        end

    end

    def create
        if current_user.payment_id.blank? 
            @payment = Payment.new(payment_params) 
            @payment.user_id = params[:user_id]
            #@payment.user gets user
                if @payment.save                        flash.notice = "Payment information saved"
                    current_user.update_column(:payment_id, @payment.id)
                    #current user.payment = payment
                    redirect_to user_payments_path
                else
                    flash.alert = "Unable to save payment information"
                    render('new')
                end
        else
            redirect_to user_payment_path
        end
        # else
        #     redirect_to user_payments_path(current_user)
        # end
    end

    def edit
        @user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
    end

    def update
        @user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
        if @payment.update(payment_params)
            flash.notice = "Payment information updated"
            redirect_to user_payments_path
        else
            flash.alert = "Unable to update payment information"
            render ('edit')
        end
    end

    def check_user
        # Rails.logger.debug "current_user.id: #{current_user.id}"
        # Rails.logger.debug "params[:user_id]: #{params[:user_id]}"
        if current_user.id != params[:user_id].to_i
            #flash.alert = "Access prohibited"
            redirect_to user_payments_path(current_user)
            #change this redirect to take you back to profile editing page
        end
    end
    
    def check_payment
        if current_user.payment_id != params[:id].to_i
            redirect_to user_payments_path(current_user)
            #change redirect to take you back to profile
        end
    end

    private
    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_number, :cvv, :exp_month, :exp_year)
    end

end

require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe 'helpers' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
    end

    describe '#tutor_options' do
      it 'populates a list of available tutors' do
        @t = create(:tutor)
        expect(controller.send(:tutor_options)[1]).to eq [@t.name, @t.id]
      end
    end
  end

  describe 'endpoints' do
    describe 'GET #index' do
      before do
        affiliate = create(:affiliate)

        create(:coordinator, affiliate: affiliate)

        student1 = create(:student)
        student2 = create(:student)

        create(:enrollment, student: student1, affiliate: affiliate)

        @all_students = [student1, student2]
        @coordinator_students = [student1]
      end

      describe 'as admin' do
        before do
          user = User.new(role: 2)
          sign_in_auth(user)
        end

        it 'populates an array of all students' do
          get :index
          expect(assigns(:students)).to eq(@all_students)
        end

        it 'renders the :index view' do
          get :index
          expect(response).to render_template :index
        end
      end

      describe 'as coordinator' do
        before do
          user = User.new(role: 1, coordinator_id: 1)
          sign_in_auth(user)
        end

        it "populates an array of coordinator's students" do
          get :index
          expect(assigns(:students)).to eq(@coordinator_students)
        end

        it 'renders the :index view' do
          get :index
          expect(response).to render_template :index
        end
      end

      describe 'as tutor' do
        before do
          user = User.new(role: 0, tutor_id: 1)
          sign_in_auth(user)
        end

        it 'redirects to the welcome view' do
          get :index
          expect(response).to redirect_to root_path
        end
      end
    end

    describe 'GET #show' do
      before do
        user = User.new(role: 2)
        sign_in_auth(user)
        @student = create(:matched_student)
      end

      it 'populates the specified student' do
        get :show, params: { id: @student }
        expect(assigns(:student)).to eq(@student)
      end

      it 'popultes a match' do
        match = Match.where(student_id: @student.id).take
        get :show, params: { id: @student }
        expect(assigns(:match)).to eq(match)
      end

      it 'renders the :show view' do
        get :show, params: { id: @student }
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
    end

    it 'populates a new student' do
      get :new
      expect(assigns(:student)).to be_a_new(Student)
    end

    it 'renders the :new view' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
      @student = create(:student)
    end

    it 'populates the specified student' do
      get :edit, params: { id: @student }
      expect(assigns(:student)).to eq(@student)
    end

    it 'renders the :edit view' do
      get :edit, params: { id: @student }
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
      @student_attrs = attributes_for(:student)
    end

    context 'with valid attributes' do
      it 'saves the new student in the database' do
        post :create, params: { student: @student_attrs }
        expect(assigns(:student)).to be_persisted
      end

      it 'assigns the newly created student as @student' do
        post :create, params: { student: @student_attrs }
        expect(assigns(:student)).to be_a(Student)
      end

      it 'redirects to the newly created student view' do
        post :create, params: { student: @student_attrs }
        expect(response).to redirect_to(Student.last)
      end
    end

    context 'with invalid attributes' do
      before do
        user = User.new(role: 2)
        sign_in_auth(user)
        allow_any_instance_of(Student).to receive(:save) { false }
      end

      it 'assigns a newly created but unsaved purchase as @purchase' do
        post :create, params: { student: @student_attrs }
        expect(assigns(:student)).to be_a_new(Student)
      end

      it 're-renders the :new view' do
        post :create, params: { student: @student_attrs }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
      @student = create(:student)
      @new_student_attrs = attributes_for(:student)
    end

    context 'with valid attributes' do
      it 'saves the new student in the database' do
        post :update, params: { id: @student, student: @new_student_attrs }
        expect(Student.last.first_name).to eq(@new_student_attrs[:first_name])
      end

      it 'assigns the updated student as @student' do
        post :update, params: { id: @student, student: @new_student_attrs }
        expect(assigns(:student).first_name)
          .to eq(@new_student_attrs[:first_name])
      end

      it 'redirects to the student view' do
        post :update, params: { id: @student, student: @new_student_attrs }
        expect(response).to redirect_to(@student)
      end
    end

    context 'with invalid attributes' do
      before do
        user = User.new(role: 2)
        sign_in_auth(user)
        allow_any_instance_of(Student).to receive(:update) { false }
      end

      it 'assigns the existing student as @student' do
        post :update, params: { id: @student, student: @new_student_attrs }
        expect(assigns(:student)).to eq(@student)
      end

      it 're-renders the :edit view' do
        post :update, params: { id: @student, student: @new_student_attrs }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update_tags' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
      @student = create(:student)
      @params = { id: @student.id, student: { 'all_tags' => ['', 'test'] } }
    end

    context 'with valid attributes' do
      it 'updates the tags for a student' do
        patch :update_tags, params: @params
        expect(Student.last.tags).to eq([Tag.last])
        expect(Tag.last.name).to eq 'test'
      end

      it 'redirects to the student view' do
        post :update, params: @params
        expect(response).to redirect_to(@student)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
    end
    it 'destroys the student' do
      student = create(:student)
      expect { delete :destroy, params: { id: student } }
        .to change(Student, :count).by(-1)
    end
    it 'redirects to the :index view' do
      student = create(:student)
      delete :destroy, params: { id: student }
      expect(response).to redirect_to students_path
    end
  end

  describe 'PUT #set_tutor' do
    before do
      user = User.new(role: 2)
      sign_in_auth(user)
    end
    context 'when tutor_id is zero' do
      before do
        @tutor_id = 0
      end

      it 'does not set up a new match for the student' do
        student = create(:student)
        put :set_tutor, params: { tutor_id: @tutor_id, student_id: student }
        expect(Match.where(student_id: student, end: nil).length).to be(0)
      end

      context 'when student has a tutor' do
        it 'unmatches the current tutor' do
          student = create(:matched_student)
          tutor_id = Match.where(student_id: student).take.tutor_id
          put :set_tutor, params: { tutor_id: @tutor_id, student_id: student }
          expect(
            Match.where(student_id: student, tutor_id: tutor_id).take.end
          ).not_to eq(nil)
        end
      end
    end

    context 'when tutor_id is nonzero' do
      before do
        @tutor = create(:employed_tutor)
      end

      context 'when the student does not have a tutor' do
        it 'matches the student with the specified tutor' do
          student = create(:matched_student)
          Enrollment.where(student: student)
                    .update(affiliate_id: @tutor.active_affiliate.id)
          put :set_tutor, params: { tutor_id: @tutor, student_id: student }
          expect(
            Match.where(student_id: student, tutor_id: @tutor).length
          ).to eq(1)
        end
      end

      context 'when student has a tutor' do
        before(:each) do
          @student = create(:matched_student)
          Enrollment.where(student: @student)
                    .update(affiliate_id: @tutor.active_affiliate.id)
          @old_tutor = Match.where(student_id: @student).take.tutor_id
        end

        context "when specified tutor is student's current tutor" do
          before do
            @new_tutor = @old_tutor
            VolunteerJob.where(tutor: @new_tutor)
                        .update(affiliate_id: @tutor.active_affiliate.id)
          end

          it "does not unmatch the student's current tutor" do
            put :set_tutor, params: {
              tutor_id: @new_tutor, student_id: @student
            }
            expect(
              Match.where(
                student_id: @student, tutor_id: @old_tutor, end: nil
              ).length
            ).to eq(1)
          end

          it 'does not set up a new match for the student' do
            put :set_tutor, params: {
              tutor_id: @new_tutor, student_id: @student
            }
            # That is, the student started with and ended with exactlt 1 match
            expect(Match.where(student_id: @student).length).to eq(1)
          end
        end

        context "when specified tutor is not student's current tutor" do
          before do
            @new_tutor = create(:employed_tutor)
            VolunteerJob.where(tutor: @new_tutor)
                        .update(affiliate_id: @tutor.active_affiliate.id)
          end

          it "unmatches the student's current tutor" do
            put :set_tutor, params: {
              tutor_id: @new_tutor, student_id: @student
            }
            expect(
              Match.where(
                student_id: @student, tutor_id: @old_tutor, end: nil
              ).length
            ).to eq(0)
          end

          it 'matches the student with the specified tutor' do
            put :set_tutor, params: {
              tutor_id: @new_tutor, student_id: @student
            }
            expect(
              Match.where(
                student_id: @student, tutor_id: @new_tutor, end: nil
              ).length
            ).to eq(1)
          end
        end
      end
    end
  end
end

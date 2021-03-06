# rubocop:disable ModuleLength, MethodLength
module TutorsHelper
  def native_language
    [
      ['English', 'English'],
      ['Albanian', 'Albanian'],
      ['Arabic', 'Arabic'],
      ['Bosnian', 'Bosnian'],
      ['Cambodian', 'Cambodian'],
      ['Cape Verdean Creole', 'Cape Verdean Creole'],
      ['Chinese', 'Chinese'],
      ['Chinese-Cantonese', 'Chinese-Cantonese'],
      ['Chinese-Mandarin', 'Chinese-Mandarin'],
      ['Chinese-Toisanese', 'Chinese-Toisanese'],
      ['Creole', 'Creole'],
      ['French', 'French'],
      ['German', 'German'],
      ['Greek', 'Greek'],
      ['Haitian Creole', 'Haitian Creole'],
      ['Hindi', 'Hindi'],
      ['Italian', 'Italian'],
      ['Japanese', 'Japanese'],
      ['Khmer', 'Khmer'],
      ['Korean', 'Korean'],
      ['Laotian', 'Laotian'],
      ['Polish', 'Polish'],
      ['Portuguese', 'Portuguese'],
      ['Russian', 'Russian'],
      ['Somali', 'Somali'],
      ['Spanish', 'Spanish'],
      ['Thai', 'Thai'],
      ['Vietnamese', 'Vietnamese']
    ]
  end

  def language_proficiency
    # [ 'None', 'Beginner', 'Intermediate', 'Advanced', 'Native', 'Native']
    [
      ['None', 'None'],
      ['Beginner', 'Beginner'],
      ['Intermediate', 'Intermediate'],
      ['Advanced', 'Advanced'],
      ['Native', 'Native']
    ]
  end

  def education
    [
      ['US High School Diploma', 'US High School Diploma'],
      ['GED', 'GED'],
      ['Equivalent of HS Diploma in another country',
       'Equivalent of HS Diploma in another country'],
      ['Adult Diploma/External Diploma Program',
       'Adult Diploma/External Diploma Program'],
      ['Some College', 'Some College'],
      ['Associate\'s Degree (2 yrs beyond HS)',
       'Associate\'s Degree (2 yrs beyond HS)'],
      ['Bachelor\'s Degree (4 yrs beyond HS)',
       'Bachelor\'s Degree (4 yrs beyond HS)'],
      ['Masters Degree', 'Masters Degree'],
      ['Doctorate (Ed.D, Ph.D)', 'Doctorate (Ed.D, Ph.D)'],
      ['Professional Degree (MD, JD)', 'Professional Degree (MD, JD)']
    ]
  end

  def referral
    [
      ['ABE Center', 'ABE Center'],
      ['Brochure/Poster/Flyer', 'Brochure/Poster/Flyer'],
      ['Church', 'Church'],
      ['Community Center/Meeting', 'Community Center/Meeting'],
      ['Coordinator', 'Coordinator'],
      ['Employer', 'Employer'],
      ['Family', 'Family'],
      ['Friend', 'Friend'],
      ['Hospital', 'Hospital'],
      ['Internet', 'Internet'],
      ['Library', 'Library'],
      ['Magazine', 'Magazine'],
      ['Newspaper', 'Newspaper'],
      ['Student (Current/Previous)', 'Student (Current/Previous)'],
      ['Other Tutor', 'Other Tutor'],
      ['Phone Book', 'Phone Book'],
      ['Presentation', 'Presentation'],
      ['Radio', 'Radio'],
      ['School', 'School'],
      ['Senior Center', 'Senior Center'],
      ['State Agency', 'State Agency'],
      ['TV', 'TV'],
      ['United Way', 'United Way'],
      ['Volunteer Fair', 'Volunteer Fair'],
      ['Other', 'Other']
    ]
  end

  def employment
    [
      ['Employed', 'Employed'],
      ['Homemaker', 'Homemaker'],
      ['Retired or Not Looking', 'Retired or Not Looking'],
      ['Student', 'Student'],
      ['Unemployed & Looking', 'Unemployed & Looking'],
      ['Unemployed & Not Looking', 'Unemployed & Not Looking']
    ]
  end

  def language_proficiencies
    # Returns a hash like { "English => "None", "Spanish" => "None" }
    Hash[(native_language.map { |e| e[0] }).collect { |v| [v, 'None'] }]
  end

  def general_contact_preferences
    [
      ['Cell Phone', 'Cell Phone'],
      ['Home Phone', 'Home Phone'],
      ['Work Phone', 'Work Phone'],
      ['Email', 'Email'],
      ['Mail', 'Mail']
    ]
  end

  def roster_contact_preferences
    [
      ['Cell Phone', 'Cell Phone'],
      ['Home Phone', 'Home Phone'],
      ['Work Phone', 'Work Phone'],
      ['Email', 'Email'],
      ['Mail', 'Mail'],
      ['None', 'None']
    ]
  end

  def status_options
    [
      ['Active', 'Active'],
      ['Waiting for re-match', 'Waiting for re-match'],
      ['Waiting for 1st match', 'Waiting for 1st match'],
      ['On hold', 'On hold'],
      ['Exited', 'Exited'],
      ['Unable to contact', 'Unable to contact'],
      ['Declined match', 'Declined match'],
      ['Moved', 'Moved'],
      ['No show to appointment', 'No show to appointment'],
      ['Dropped out of training', 'Dropped out of training'],
      ['Cannot match', 'Cannot match']
    ]
  end

  def preferred_student_level
    [
      ['No Preference', 'No Preference'],
      ['Beginner', 'Beginner'],
      ['Intermediate', 'Intermediate'],
      ['Advanced', 'Advanced']
    ]
  end

  module_function :education,
                  :employment,
                  :language_proficiencies,
                  :native_language,
                  :referral,
                  :status_options
end

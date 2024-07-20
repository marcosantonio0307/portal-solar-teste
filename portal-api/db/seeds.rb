# frozen_string_literal: true

puts "**** Creating Power Generators **** \n"

PopulatePowerGeneratorsUseCase.call(total_pages: 40, page_size: 50) if PowerGenerator.count.zero?

puts "**** Finished creating Power Generators **** \n

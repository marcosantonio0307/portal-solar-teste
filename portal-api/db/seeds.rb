# frozen_string_literal: true

PopulatePowerGeneratorsUseCase.call(total_pages: 40, page_size: 50) if PowerGenerator.count.zero?

# frozen_string_literal: true

def param_value(subject, type, title, param)
  subject.resource(type, title).send(:parameters)[param.to_sym]
end

#
# cmpi.rb
#
# Main entry point for cmpi-bindings-ruby, Ruby based CIM Providers
#

class String
  #
  # Convert from CamelCase to under_score
  #
  def decamelize
    self.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
	 gsub(/([a-z\d])([A-Z])/,'\1_\2').
	 tr("-", "_").
	 downcase
  end
end

#
# = Cmpi - Common Manageablity Programming Interface
#
# The Common Manageablity Programming Interface (CMPI) defines a common standard of interfacing Manageability Instrumentation (providers, instrumentation) to Management Brokers (CIM Object Manager). The purpose of CMPI is to standardize Manageability Instrumentation. This allows to write and build instrumentation once and run it in different CIM environments (on one platform).
#
# == CIMOM Context
#
# == Provider Interface
#

module Cmpi

  #
  # CMPIContext gives the context for Provider operation
  #
  class CMPIContext
    def count
      #can't use alias here because CMPIContext::get_entry_count is only defined after
      # initializing the provider (swig init code)
      get_entry_count
    end
    def [] at
      if at.kind_of? Integer
	get_entry_at( at )
      else
	get_entry( at.to_s )
      end
    end
    def each
      0.upto(self.count-1) do |i|
	yield get_entry_at(i)
      end
    end
  end
  
  #
  # CMPIInstance
  #
  class CMPIInstance
    def each
      (0..self.size-1).each do |i|
	yield self.get_property_at(i)
      end
    end
    def to_s
      s = ""
      self.each do |value,name|
	next unless value
	s << ", " unless s.empty?
	s << "\"#{name}\" => #{value.inspect}"
      end
      s = "#{self.class}(" + s + ")"
    end
  end
end

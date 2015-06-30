# This abstracts the class since we do not have a 'version' table
PaperTrail::Version.module_eval do
  self.abstract_class = true
end

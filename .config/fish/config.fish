# Define JAVA_HOME from asdf
if command -qv asdf
    set -gx JAVA_HOME (asdf env java | rg JAVA_HOME | string split -f2 =)
end

# Enable starship.rs prompt
if command -qv starship
    starship init fish | source
end

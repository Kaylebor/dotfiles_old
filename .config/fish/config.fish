# Define JAVA_HOME from asdf
if command -qv asdf
    set -gx JAVA_HOME (asdf env java | rg JAVA_HOME | string split -f2 =)
end

# Enable starship.rs prompt
if command -qv starship
    starship init fish | source
end

# Add abbreviations
if status is-interactive
    abbr squex-otp op item --account=my get km4dyqvadk4xmuudlamwzblaiu --otp
    abbr restart-emacsd brew services restart emacs-plus@28
end

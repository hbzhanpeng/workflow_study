echo '--- Starting Remote CI Check ---'
npm run lint
if [ $? -eq 0 ]; then
  echo '✅ CI Passed: Code quality meets standards.'
  exit 0
else
  echo $?
  echo '❌ CI Failed: Bad code detected! Merge blocked.'
  exit 1
fi

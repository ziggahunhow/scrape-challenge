import axios from 'axios';
import cheerio from 'cheerio';
import fs from 'fs'

const getCsrf = async () => {
  let csrf = '';
  await axios.get('https://f2e-test.herokuapp.com/login').then(response => {
    const $ = cheerio.load(response.data);
    csrf = $('input[name="csrf"]').val();
  });
  return csrf;
};

const writeFile = csrf => {
  fs.writeFile('csrf.txt', csrf, (err) => {
    if (err) console.log(err);
    console.log('Successfully Written to File.');
  });
}

(async () => {
  const csrf = await getCsrf()
  writeFile(csrf)
})();

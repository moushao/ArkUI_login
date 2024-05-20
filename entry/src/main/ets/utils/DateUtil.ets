export default function getCurrentTime(): string {
  let date = new Date();
  let year = date.getFullYear();
  let month = date.getMonth() + 1;
  let day = date.getDate();
  let hours = date.getHours();
  let minutes = date.getMinutes().toString();
  if (Number.parseInt(minutes) < 10) {
    minutes = `0${minutes}`;
  }
  let second = date.getSeconds().toString();
  if (Number.parseInt(second) < 10) {
    second = `0${second}`;
  }
  return `${year}/${month}/${day} ${hours}:${minutes}:${second}`;
}
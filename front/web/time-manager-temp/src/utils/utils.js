import moment from 'moment';

const calculateTotalWorkingTime = (w) => {
      console.log(w);
      const start = moment(w.start);
      const end = moment(w.end);
      const duration = moment.duration(end.diff(start));
      const totalDurationInMinutes = duration.asMinutes();
      const hours = Math.floor(totalDurationInMinutes / 60);
      const minutes = totalDurationInMinutes % 60;
      console.log(hours, minutes);
      const totalWorkedtime = `${hours}h: ${minutes}m`;
      return totalWorkedtime;
  }

  export { calculateTotalWorkingTime };
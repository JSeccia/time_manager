import moment from 'moment';
import axios from 'axios';

// getWTs = async () => {
//     const response = await axios.get(`api/workingtimes`)
//     if(response.status === 200) {
//     const wts = response.data.data
//     console.log(wts);
//     }
// }

async function getWTs() {
    const response = await axios.get(`api/workingtimes`)
    if (response.status === 200) {
        const wts = response.data.data
        console.log(wts, 'wts');
    }
}

// recupere les working times 
// on map dessur pour
// recupere le start et le end de tous les wt des users 
// on les convertis en moment et en minutes
// on les additionne
// on divise par le nombre de wt
// on retourne le resultat




export default getWTs; 
<template>
  <br>
  <h3>Employee {{ currentUserId }} Working Times:</h3>
  <form @submit="getWorkingTimes">
    <label for="get_user_working_times" placeholder="enter employee id"></label>
  </form>
  <div class="q-pa-md">
    <q-table title="Working Times by Users ID" :rows="rows" :columns="columns" row-key="name" />
  </div>
</template>

<script>

import axios from "axios";
import { defineComponent } from "vue";

export default defineComponent({
  name: "WorkingTimesTest",

  setup() {
    return {
      columns,
      rows
    }
  },

  data() {

    return {
      workingTimes: {
        userId: 0,
      },
      currentUserId: "",
    };
  },
  methods: {
    getWorkingTimes(submitNumber) {
      submitNumber.preventDefault();

      if (this.userId === "") {
        window.alert("Please enter an employee id");
        return;
      }
      axios
        .get(`http://192.168.76.161:4000/api/working_times/${this.userId}`)
        .then((response) => {
          if (response.data.data.length > 0) {
            this.workingTimes = response.data.data;
            this.currentUserId = this.$refs.userIdInput.value;
          } else {
            window.alert("No employer or working times found");
          }
        });
    },
  },
});

const columns = [
  {
    name: 'name',
    required: true,
    label: 'Users ID',
    align: 'left',
    field: row => row.name,
    format: val => `${val}`,
    sortable: true
  },
  { name: 'Heure arrivée', align: 'center', label: 'Heure arrivée', field: 'Heure', sortable: true },
  { name: 'Heure départ', label: 'Heure départ', field: 'Depart', sortable: true },
  { name: 'Temps de travail total', label: 'Temps de travail total', field: 'Total' },
]

const rows = [
  {
    name: 'Lundi',
    Heure: 7.30,
    Depart: 18,
    Total: 9
  },
  {
    name: 'Mardi',
    Heure: 9,
    Depart: 16,
    Total: 9
  },
  {
    name: 'Mercredi',
    Heure: 9,
    Depart: 19,
    Total: 9
  },
  {
    name: 'Jeudi',
    Heure: 8,
    Depart: 17,
    Total: 9
  },
  {
    name: 'Vendredi',
    Heure: 9,
    Depart: 18,
    Total: 9
  }
]

</script>
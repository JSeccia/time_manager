<template>
  <main class="main_teams">
    <section v-if="currentUser.role === 'admin'" class="managing_teams">
      <h1>Manage Teams</h1>
      <q-btn label="Create Team" @click="handleTeamCreate" />
      <div class="display-teams">
        <table class="teams-table">
          <thead>
            <th>Team</th>
            <th>Manager</th>
            <th>Total Members</th>
          </thead>
          <tbody>
            <tr class="T_items" v-for="team in teams" :key="team.id">
              <td>
                <input
                  type="button"
                  class="select_team"
                  :value="team.id"
                  @click.prevent="goTeamShow"
                />
              </td>
              <td>{{ team.manager }}</td>
              <td>{{ team.users.length }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <form
        id="create-form"
        v-if="isTeamCreateBtnClicked"
        @submit.prevent="createTeam"
      >
        <fieldset>
          <h2 class="fs-title">Create a new Team</h2>
          <label for="manager_input">Manager Id</label>
          <input
            type="text"
            v-model="manager"
            id="manager_input"
            name="manager_input"
          />
          <br />
          <q-btn
            id="create-submit"
            type="submit"
            class="create_wt_btn"
            push
            color="green-10"
            label="create"
          />
        </fieldset>
      </form>
    </section>

    <section v-if="currentUser.role === 'manager'" class="managing_teams">
      <TeamComponent />
    </section>
  </main>
</template>

<script>
import { useUserStore } from "src/stores/store-users";
import axios from "axios";
import TeamComponent from "./TeamComponent.vue";

export default {
  name: "TeamsComponent",
  components: {
    TeamComponent,
  },
  setup() {
    const store = useUserStore();
    return {
      store,
    };
  },
  data() {
    return {
      currentUser: this.store.user,
      currentTeamSelected: "",
      teams: {},
      teamId: "",
      team: {},
      isTeamCreateBtnClicked: false,
      teamWithManagerId: {},
    };
  },

  methods: {
    getTeams() {
      axios.get("/api/teams").then((response) => {
        this.teams = response.data.data;
        // this.teamsUsers = teams.map((team) => {
        //   return {
        //     id: team.find((user) => user.team_id).team_id,
        //     manager: team.find((user) => user.role === "manager").id,

        //     users: team.map((t) => (t.role === "user" ? t.username : "")),
        //   };
        // });
        // console.log(this.teams, "teams");
        //  this.managerId = this.teams.map((team) => {
        //     return team.manager })
        // console.log(this.managerId, "this.managerId");
        //  this.ids = this.managerId.map((id) => {
        //     return id
        // });
        // console.log(this.ids, "this.ids");
        // for (let i = 0; i < this.ids.length; i++) {
        //     if (this.ids[i] === this.teams[i].manager) {
        //         this.id = this.ids[i]
        //         console.log(this.id, "this.id");
        //         axios
        //         .get(`/api/teams/manager/${this.id}`)
        //         .then((response) => {
        //             console.log(response.data.data, "response.data.data");
        //             this.teamWithManagerId = response.data.data;
        //             console.log(this.teamWithManagerId, "this.teamWithManagerId");
        //             console.log(this.id, "this.id");
        //     })
        //     } else {
        //         console.log("no id");
        //     }
        // }
        // console.log(this.id, "this.id");
      });
    },
    goTeamShow(e) {
      axios.get(`/api/teams/${this.currentTeamSelected}`).then((response) => {
        this.currentTeamSelected = e.target.value;
        this.team = response.data.data;
        console.log(this.team, "team");
        console.log(this.currentTeamSelected, "current team selected");
        this.$router.push(`/teams/${this.currentTeamSelected}`);
      });
    },
    handleTeamCreate() {
      this.isTeamCreateBtnClicked = true;
    },
    createTeam() {
      const body = {
        team: {
          manager: this.manager,
        },
      };
      axios
        .post("/api/teams", body, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((response) => {
          console.log(response.data, "team created");
          this.teams.push(response.data);
        });
      console.log(body, "body");
    },
  },
  mounted() {
    this.getTeams();
  },
};
</script>

<style>
.unauthorize {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  margin: 0 auto;
  border-bottom: none;
  color: red;
}

.managing_teams {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 90%;
}
.display-teams {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.teams-table {
  width: 100%;
  font-weight: 700;
  text-align: center;
}

.teams-table thead {
  display: flex;
  justify-content: space-between;
  width: 100%;
  border: 1px solid green;
}

.teams-table thead th {
  width: 100%;
  padding: 4px;
  text-align: center;
  color: black;
  background-color: none;
  display: flex;
  justify-content: space-around;
  background-color: #4caf50;
}

.teams-table tbody {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 1px solid green;
}

.teams-table tbody .T_items {
  border-bottom: 1px solid rgb(236, 231, 231);
  width: 100%;
  padding: 4px;
  text-align: center;
  color: black;
  background-color: none;
  display: flex;
  justify-content: space-around;
}

.select_team {
  border: none;
  background-color: transparent;
}

.select_team:hover {
  color: #4caf50;
  border-color: #4caf50;
  text-decoration: none;
}
</style>

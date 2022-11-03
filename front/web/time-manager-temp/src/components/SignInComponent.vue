<template>
    <main class="main_login">
        <div class="login_section">
            <div class="login_title">
                <p color="green-10">Welcome on Time Manager</p>
            </div>
            <div class="login_section__form">
                <p>Create your account now !</p>
                <q-input rounded outlined v-model="text" class="input_login" label="Username" color="green-10">
                </q-input>
                <q-input rounded outlined v-model="text" class="input_login" label="Password" color="green-10"
                    type="password">
                </q-input>
                <q-input rounded outlined v-model="text" class="input_login" label="Re-type your password"
                    color="green-10" type="password">
                </q-input>
                <q-btn class="input_btn" push color="green-10" label="Connect" />
                <div class="oubli_psswd">
                    <p>Already got an account ?</p>
                </div>
            </div>
        </div>
    </main>
</template>


<script>

export default {
    name: "LoginComponent",
}

</script>


<style>
.main_login {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 90vh;
}

.login_section {
    width: 50%;
    height: 85%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    background-color: #9AE691;
    box-shadow: 0 0 0 2px white;
    border-radius: 8px;

}

.login_title {
    font-size: 30px;
    font-weight: bold;
    border-bottom: 3px solid black;
    margin-top: 13%;
    display: flex;
    align-items: center;
    height: 5%;
}


.login_section__form {
    color: black;
    height: 70%;
    width: 80%;
    margin-bottom: 5%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
}


.input_login {
    justify-content: center;
    align-items: center;
    width: 80%;
    margin: 2%;
}

.input_btn {
    margin: 1%;
}

.oubli_psswd {
    font-size: 15px;
    font-weight: bold;
    color: black;
    height: 10%;
    margin: 2%;
}
</style>
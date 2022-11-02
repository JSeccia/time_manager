<template>
    <main class="main-profile">
        <div class="profile-section">
            <div class="login-section">
                <div class="login-section__title">
                    <h1>Time Manager</h1>
                </div>
                <div class="login-section__form">
                    <form @submit.prevent="login">
                        <div class="login-section__form__input">
                            <label for="email">Email</label>
                            <input type="email" id="email" v-model="email" />
                        </div>
                        <div class="login-section__form__input">
                            <label for="password">Password</label>
                            <input type="password" id="password" v-model="password" />
                        </div>
                        <div class="login-section__form__input">
                            <button type="submit">Login</button>
                        </div>
                    </form>
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
.main-profile {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 90vh;
}


.profile-section {
    width: 30%;
    height: 80%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-around;
    background-color: #9AE691;
    box-shadow: 0 0 0 2px white;
    border-radius: 8px;

}
</style>
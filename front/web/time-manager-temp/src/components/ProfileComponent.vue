<template>
    <main class="main-profile">
    <div class="profile-section">
        
        <div class="avatar">
            
            <img class="avatar-img" src="../assets/images/avatar-manager.jpg" alt="user avatar"/>
            <span>username</span>

            
        </div>

        <div class="profile-info">
            <table>
                <tbody>
                    <tr>
                        <td>
                            email
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="edit-password">
                                <p>password  <q-icon name="edit" /></p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Role : Manager</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Employee Numbers:  </span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="logout-button">
            <q-btn style="background-color: #4CAF50; color: white" label="Logout" />
        </div>

    </div>
</main>

</template>

<script>

export default {
    name: 'ProfileComponent',
};
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
    height: 60%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-around;
    background-color: rgba(76, 175, 80, 0.14);
    box-shadow: 0 0 0 2px white;
    border-radius: 8px;
}

.avatar {
    width: 30%;
    height: 35%;
    text-align: center;
    margin-bottom: 10px;    
}
.avatar-img {
    height: 135px;
    width: 100%;
    border-radius: 50%;
}
.profile-info {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    width: 80%;
    font-size: 15px;
}

.profile-info table {
    width: 100%;
    height: 100%;
    border-collapse: collapse;
    border: none;
    font-weight: 400;
}

</style>
<template>
    <div>
        <ProfileComponent />
    </div>
</template>


<script>

import { defineComponent } from 'vue';
import ProfileComponent from 'src/components/ProfileComponent.vue';

export default defineComponent({
    name: 'ProfilePage',

    components: {
        ProfileComponent,
    },
});

</script>
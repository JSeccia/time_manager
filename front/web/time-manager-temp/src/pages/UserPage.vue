<template>
    <div>
        <UserComponent />
    </div>
</template>


<script>

import { defineComponent } from 'vue';
import UserComponent from 'src/components/UserComponent.vue';

export default defineComponent({
    name: 'UserPage',

    components: {
        UserComponent,
    },
});

</script>
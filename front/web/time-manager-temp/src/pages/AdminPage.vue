<template>
    <div>
        <AdminComponent />
    </div>
</template>

<script>
import { defineComponent } from 'vue';
import AdminComponent from 'src/components/AdminComponent.vue';

export default defineComponent({
    name: 'AdminPage',

    components: {
        AdminComponent,
    },

});
</script>